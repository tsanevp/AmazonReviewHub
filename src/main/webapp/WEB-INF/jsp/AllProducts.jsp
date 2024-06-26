<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>All Products</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style type="text/css">
/* Custom CSS styling */
body {
	font-family: Arial, sans-serif;
}

.box {
	padding: 20px;
}

h1 {
	margin-bottom: 30px;
}

table {
	width: 100%;
	border-collapse: collapse;
	margin-bottom: 30px;
}

th, td {
	padding: 10px;
	border: 1px solid #ddd;
	text-align: left;
}

th {
	background-color: #f2f2f2;
}

tr:nth-child(even) {
	background-color: #f2f2f2;
}

a {
	text-decoration: none;
	color: #007bff;
}

a:hover {
	text-decoration: underline;
}

.del-button {
	border: none;
	background-color: transparent;
	text-decoration: underline;
	padding-left: 0px;
}

.box {
	/* Ensure the box does not overflow */
	overflow-x: hidden;
}

.pagination {
	/* Fixed width for the pagination box */
	width: 100%;
	/* Enable horizontal scrolling */
	overflow-x: auto;
}

.pagination-numbers {
	/* Prevent pagination numbers from wrapping */
	white-space: nowrap;
	margin-bottom: 10px;
}

.pagination-list {
	/* Use flexbox to align pagination numbers */
	display: flex;
	/* Remove default padding and margin */
	padding: 0;
	margin: 0;
	/* Ensure list items are displayed in a row */
	flex-direction: row;
}

.pagination-list li {
	/* Add some spacing between pagination numbers */
	margin-right: 5px;
}

.pagination-list li:last-child {
	/* Remove margin for the last pagination number */
	margin-right: 0;
}

/* Custom styling for links */
.link-group-vertical {
	display: flex;
	flex-direction: column;
}
</style>
</head>
<body>
	<%@ include file="Header.jsp"%>

	<div class="box">
		<h1>All Products</h1>
		<!-- Filter options -->
		<div class="mb-3">
			<form id="filterForm" action="filter_products" method="post">
				<div class="row">
					<!-- Category filter -->
					<div class="col-md-3">
						<label for="categoryFilter" class="form-label">Category:</label> <select
							name="category" class="form-select" id="categoryFilter">
							<option value="">All Categories</option>
							<c:forEach items="${categories}" var="category">
								<option value="${category.key}">${category.value}</option>
							</c:forEach>
						</select>
					</div>
					<!-- Price range filter -->
					<div class="col-md-3">
						<label for="minPrice" class="form-label">Min Price:</label> <input
							type="number" class="form-control" id="minPrice" name="minPrice"
							min="0">
					</div>
					<div class="col-md-3">
						<label for="maxPrice" class="form-label">Max Price:</label> <input
							type="number" class="form-control" id="maxPrice" name="maxPrice"
							min="0">
					</div>
					<!-- Rating filter -->
					<div class="col-md-3">
						<label for="ratingFilter" class="form-label">Rating:</label> <select
							class="form-select" id="ratingFilter" name="rating">
							<option value="">Any Rating</option>
							<option value="5">5 Stars</option>
							<option value="4">4 Stars and Up</option>
							<option value="3">3 Stars and Up</option>
							<option value="2">2 Stars and Up</option>
							<option value="1">1 Star and Up</option>
						</select>
					</div>
					<!-- Number of reviews filter -->
					<div class="col-md-3">
						<label for="minReviews" class="form-label">Min Reviews:</label> <input
							type="number" class="form-control" id="minReviews"
							name="minReviews" min="0">
					</div>
					<div class="col-md-3">
						<label for="maxReviews" class="form-label">Max Reviews:</label> <input
							type="number" class="form-control" id="maxReviews"
							name="maxReviews" min="0">
					</div>
					<!-- Bestseller filter -->
					<div class="col-md-3">
						<label for="bestsellerFilter" class="form-label">Bestseller:</label>
						<select class="form-select" id="bestsellerFilter"
							name="bestSeller">
							<option value="">Either</option>
							<option value="true">Yes</option>
							<option value="false">No</option>
						</select>
					</div>
					<!-- Order by filter -->
					<div class="col-md-3">
						<label for="orderBy" class="form-label">Order of Price
							Filter :</label> <select class="form-select" id="orderBy" name="orderBy">
							<option value="none"></option>
							<option value="asc">Ascending</option>
							<option value="desc">Descending</option>
						</select>
					</div>
					<!-- Apply filter button -->
					<div class="col-md-3 mt-4">
						<button type="submit" class="btn btn-primary">Apply
							Filters</button>
						<button type="button" class="btn btn-secondary"
							onclick="clearFilters()">Clear Filters</button>
					</div>

				</div>
			</form>
		</div>

		<table class="table">
			<thead class="table-light">
				<tr>
					<th>Title</th>
					<th>Price (USD)</th>
					<th>Image</th>
					<th>Category Name</th>
					<th>See on Amazon</th>
					<th>Stars</th>
					<th>Reviews</th>
					<th>Is Best Seller</th>
					<th>Actions</th>
				</tr>
			</thead>
			<tbody id="filteredProductsTableBody">
				<c:forEach items="${products}" var="product">
					<tr>
						<td>${product.getTitle()}</td>
						<td>${product.getPrice()}</td>
						<td><img src="${product.getImageUrl()}" alt="Product Image"
							style="max-width: 100px;"></td>
						<td>${categories[product.categoryId]}</td>
						<td><a href="${product.getProductUrl()}" target="_blank">View
								Product</a></td>
						<td>${product.getStars()}</td>
						<td>${product.getReviews()}</td>
						<td>${product.isBestSeller()}</td>
						<!-- Add more columns as needed -->
						<td>
							<div class="link-group-vertical">
								<!-- Add actions here -->
								<a href="#" onclick="seePosts('${product.getProductId()}')">See
									Posts</a> <a href="#"
									onclick="createPost('${product.getProductId()}')">Create
									Post</a> <a href="#"
									onclick="addToWishlist('${product.getProductId()}')">Add to
									Wishlist</a>
							</div>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>

	<div class="box">
		<!-- Existing content here -->

		<!-- Pagination -->
		<c:if test="${totalPages > 1}">
			<nav aria-label="Page navigation">
				<ul class="pagination">
					<!-- Pagination numbers wrapped in a div for horizontal scrollbar -->
					<li class="page-item">
						<div class="pagination-box">
							<div class="pagination-numbers">
								<ul class="pagination-list">
									<c:forEach begin="1" end="${totalPages}" var="pageNum">
										<li class="page-item ${pageNum == page ? 'active' : ''}">
											<a class="page-link" href="?page=${pageNum}">${pageNum}</a>
										</li>
									</c:forEach>
								</ul>
							</div>
						</div>
					</li>
				</ul>
			</nav>
		</c:if>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		type="text/javascript"></script>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"
		type="text/javascript"></script>

	<script>
		function seePosts(productId) {
			window.location.href = "all_posts?productId=" + productId;
		}

		function createPost(productId) {
			window.location.href = "create_post?productId=" + productId;
		}

		function addToWishlist(productId) {
			$.ajax({
				type : "POST",
				url : "my_wishlist",
				data : {
					productId : productId,
				},
				success : function(response) {
					if (response.equals("reload")) {
						location.reload();
						return;
					}
					// Reload the page after successfully joining the group
					location.reload();
				},
				error : function(xhr, status, error) {
					// Handle error if joining the group fails
					console.error(error);
					// Display an error message or perform any other action as needed
				}
			});

			alert("Product with ID " + productId + " added to wishlist!");
		}

		function applyFilters() {
			var category = $('#categoryFilter').val();
			var minPrice = $('#minPrice').val();
			var maxPrice = $('#maxPrice').val();
			var rating = $('#ratingFilter').val();
			var minReviews = $('#minReviews').val();
			var maxReviews = $('#maxReviews').val();
			var bestseller = $('#bestsellerFilter').val();
			var orderBy = $('#orderBy').val();

			$.ajax({
				type : "GET",
				url : "filter_products",
				data : {
					category : category,
					minPrice : minPrice,
					maxPrice : maxPrice,
					rating : rating,
					minReviews : minReviews,
					maxReviews : maxReviews,
					bestseller : bestseller,
					orderBy : orderBy
				},
				success : function(response) {
					$('#filteredProductsTableBody').html(response);
				},
				error : function(xhr, status, error) {
					console.error(error);
				}
			});
		}

		function clearFilters() {
			$('#categoryFilter').val('');
			$('#minPrice').val('');
			$('#maxPrice').val('');
			$('#ratingFilter').val('');
			$('#minReviews').val('');
			$('#maxReviews').val('');
			$('#bestsellerFilter').val('');
			$('#orderBy').val('');

			// Reload products without filters
			window.location.href = "all_products";
		}
	</script>
</body>
</html>
